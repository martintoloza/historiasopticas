class BarriosController < ApplicationController
  before_action :set_barrio, only: [:show, :edit, :update, :destroy]
  #before_filter :authenticate_user! except: [ :index, :show ]
 
  #def barriosof
  #  @ciudad_id = params[:ciudad_id]
  #  @ciudad = Ciudad.find(@ciudad_id)
  #  @barrios = @ciudad.id
  # (59) barriosof_path(@barrio.ciudad.id)
  #end

  def index
    @filterrific = initialize_filterrific(
      Barrio,
      params[:filterrific]
    ) or return
    @barrios = @filterrific.find.page(params[:page])
    # @barrios = Barrio.where(:ciudad_id => 126).order("nombre")

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @barrio = Barrio.new
    #@ciudad = Ciudad.all
  end


  def create
    @barrio = Barrio.new(barrio_params)

    respond_to do |format|
      if @barrio.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @barrio.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @barrio.update(barrio_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @barrio.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @barrio.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_barrio
      @barrio = Barrio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def barrio_params
      params.require(:barrio).permit(:nombre, :ciudad_id, :created_at, :updated_at)
    end
end
