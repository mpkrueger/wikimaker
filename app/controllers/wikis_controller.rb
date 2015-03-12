class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body))
    if @wiki.save
      flash[:notice] = "Wiki was created."
      redirect_to @wiki
    else
      flash[:error] = "Uh oh, that didn't work."
      redirect_to :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])

    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body))
      flash[:notice] = "Your wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "Uh oh, your edits were not saved."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.title

    if @wiki.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @wiki
    else
      flash[:error] = "Something went wrong and your wiki was not deleted."
      render :show
    end
  end
end
