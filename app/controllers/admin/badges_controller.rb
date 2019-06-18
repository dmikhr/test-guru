class Admin::BadgesController < Admin::BaseController
  before_action :set_badges, only: %i[index]
  before_action :set_badge, only: %i[edit update destroy]

  def index; end

  def edit; end

  def update
    if @badge.update(badge_params) && @badge.badge_rules.update(badge_rules_params)
      redirect_to admin_badges_path, notice: 'Badge updated'
    else
      render :edit
    end
  end

  def new
    @badge = Badge.new
    @badge_rules = @badge.badge_rules.new
  end

  def create
    # byebug
    @badge = Badge.new(badge_params)
    @badge_rules = @badge.badge_rules.new(badge_rules_params)
    if @badge.save && @badge_rules.save
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
    params.require(:badge).permit(:name, :description, :image_path)
  end

  def badge_rules_params
    params.require(:badge).permit(:category_id, :test_id, :level, :first_attempt)
  end

  def set_badges
    @badges = Badge.all
  end

  def set_badge
    @badge = Badge.find(params[:id])
  end
end
