class Admin::BadgesController < Admin::BaseController
  before_action :set_badges, only: %i[index]
  before_action :set_badge, only: %i[edit update destroy]

  def index; end

  def edit; end

  def update
    if @badge.update(badge_params)
      redirect_to admin_badges_path, notice: 'Badge updated'
    else
      render :edit
    end
  end

  def new
    @badge = Badge.new
  end

  def create
    # byebug
    @badge = Badge.new(badge_params)
    if @badge.save
      redirect_to admin_badges_path, notice: 'Badge saved'
    else
      render :new
    end
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path(@test)
  end

  private

  def badge_params
    params.require(:badge).permit(:name, :description, :image_path, :rule, :value)
  end

  def set_badges
    @badges = Badge.all
  end

  def set_badge
    @badge = Badge.find(params[:id])
  end
end
