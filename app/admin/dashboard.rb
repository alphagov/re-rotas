ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Org Units" do
          para [
            link_to("Org units", admin_org_units_path),
            text_node(" have many "),
            link_to("teams", admin_teams_path),
          ]
        end

        panel "Services" do
          para [
            link_to("Services", admin_services_path),
            text_node(" are assocated with many "),
            link_to("teams", admin_teams_path),
          ]
        end

        panel "Teams" do
          para [
            link_to("Teams", admin_teams_path),
            text_node(" are part of an "),
            link_to("org unit", admin_org_units_path),
          ]

          para [
            link_to("Teams", admin_teams_path),
            text_node(" are associated with many "),
            link_to("services", admin_services_path),
          ]

          para [
            link_to("Teams", admin_teams_path),
            text_node(" have many calendars"),
          ]
        end

        panel "Calendars" do
          para [
            text_node("Calendars are either "),
            link_to("manual calendars", admin_manual_calendars_path),
            text_node(" or "),
            link_to("PagerDuty calendars", admin_pager_duty_calendars_path),
          ]
        end
      end

      column do
        panel "Audit events" do
          para [
            link_to("Audit events", admin_audit_events_path),
            text_node(" are generated when users do things: "),
            text_node("eg looking up contact details"),
          ]
        end
      end
    end
  end
end
