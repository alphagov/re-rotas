class OrgUnitsController < ApplicationController
  def index
    @org_units = OrgUnit.all
  end

  def show
    @org_unit = OrgUnit.friendly.find(params[:id])
  end
end
