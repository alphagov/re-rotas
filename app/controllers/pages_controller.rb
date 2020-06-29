require 'tempfile'
require 'ruby-graphviz'

class PagesController < ApplicationController
  def home
    teams_with_empty_events = Team.all.map { |t| [t, []] }.to_h
    events_by_team = Team
      .all
      .flat_map(&:calendars)
      .flat_map(&:person_day_events)
      .select { |e| e.date == Date.today }
      .group_by { |e| e.calendar.team }

    @team_rotas = teams_with_empty_events.merge(events_by_team)
  end

  def org_map
    g = GraphViz.new(:G, type: :digraph)

    Service.all.each do |s|
      g.add_nodes("S:#{s.name}", label: s.name, shape: :rect)
    end

    Team.all.each do |t|
      g.add_nodes("T:#{t.name}", label: t.name, shape: :rect)
    end

    OrgUnit.all.each do |ou|
      g.add_nodes("OU:#{ou.name}", label: ou.name, shape: :rect)
    end

    OrgUnit.all.each do |ou|
      ou.teams.each do |t|
        g.add_edges("OU:#{ou.name}", "T:#{t.name}")
      end
    end

    Team.all.each do |t|
      t.services.each do |s|
        g.add_edges("T:#{t.name}", "S:#{s.name}")
      end
    end

    tmp = Tempfile.new('org-map-png')
    begin
      g.output(png: tmp.path)
      @org_map_image = tmp.read
    ensure
      tmp.delete
    end
  end
end
