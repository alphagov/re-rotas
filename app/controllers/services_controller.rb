class ServicesController < ApplicationController
  def index
    @services = Service.all
  end

  def show
    @service = Service.friendly.find(params[:id])

    description = @service.description || ''
    @description = Rotas::MarkdownRenderer.render(description)

    documentation = @service.documentation || ''
    @documentation = Rotas::MarkdownRenderer.render(documentation)
  end

  def new
    @service = Service.new
    @teams = Team.all
  end

  def edit
    @service = Service.friendly.find(params[:id])
    @teams = Team.all
  end

  def create
    @service = Service.new(params.require(:service).permit(
      :name,
      :description, :documentation,
      { team_ids: [] },
    ))

    unless @service.valid?
      @teams = Team.all
      return render :new
    end

    @service.save
    redirect_to service_path(@service)
  end

  def update
    @service = Service.friendly.find(params[:id])
    @service.assign_attributes(params.require(:service).permit(
      :name,
      :description, :documentation,
      { team_ids: [] },
    ))

    unless @service.valid?
      @teams = Team.all
      return render :edit
    end

    @service.save
    redirect_to service_path(@service)
  end
end
