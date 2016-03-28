class Workspace::IntroductionsController < Workspace::DashboardController
  include FindModels

  before_action -> { find_lo(params[:lo_id]) } , only: [:new, :create]
  before_action :find_introduction, only: [:destroy, :update, :show, :edit]

  def new
    @introduction = @lo.introduction.new
  end

  def update
    if @introduction.update(introduction_params)
      redirect_to [:workspace, @lo]
    else
      flash.now[:error] = "Existem dados incorretos."
      render :edit
    end
  end

  def create
    @introduction = @lo.introduction.new(introduction_params)
    if @introduction.save
      redirect_to [:workspace, @lo]
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def destroy
    @introduction.destroy
    redirect_to [:workspace, @lo]
  end

  private
    def introduction_params
      params.require(:introduction).permit(:title, :content)
    end

    def find_introduction
      find_lo(params[:lo_id])
      @introduction = @lo.introduction.find(params[:id])
    end
end
