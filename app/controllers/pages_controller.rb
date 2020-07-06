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

    node_styles = { shape: :rect, fontname: 'Helvetica-Bold', penwidth: 1.5 }
    edge_styles = { penwidth: 1.5 }

    g.subgraph do |c|
      c[:rank] = :same

      Service.all.each do |s|
        href = service_path(s)
        c.add_nodes("S:#{s.name}", label: s.name, href: href, **node_styles)
      end
    end

    g.subgraph do |c|
      c[:rank] = :same

      Team.all.each do |t|
        href = team_path(t)
        c.add_nodes("T:#{t.name}", label: t.name, href: href, **node_styles)
      end
    end

    g.subgraph do |c|
      c[:rank] = :same

      OrgUnit.all.each do |ou|
        href = org_unit_path(ou)
        c.add_nodes("OU:#{ou.name}", label: ou.name, href: href, **node_styles)
      end
    end

    OrgUnit.all.each do |ou|
      ou.teams.each do |t|
        g.add_edges("OU:#{ou.name}", "T:#{t.name}", **edge_styles)
      end
    end

    Team.all.each do |t|
      t.services.each do |s|
        g.add_edges("T:#{t.name}", "S:#{s.name}", **edge_styles)
      end
    end

    tmp = Tempfile.new('org-map-svg')
    begin
      g.output(svg: tmp.path)
      @org_map_image = tmp.read
    ensure
      tmp.delete
    end
  end
end
