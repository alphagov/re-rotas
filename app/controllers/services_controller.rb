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
  end

  def edit
    @service = Service.friendly.find(params[:id])
  end

  def create
    @service = Service.new(params.permit(
      :name,
      :description, :documentation,
    ))

    return render :new unless @service.valid?

    @service.save
    redirect_to service_path(@service)
  end

  def update
    @service = Service.friendly.find(params[:id])
    @service.assign_attributes(params.permit(
      :name,
      :description, :documentation,
    ))

    return render :edit unless @service.valid?

    @service.save
    redirect_to service_path(@service)
  end
end
