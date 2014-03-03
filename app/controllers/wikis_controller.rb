class WikisController < ApplicationController
  respond_to :html, :js
  
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new

  end

  def create
  @wiki = Wiki.new(wiki_params)
  
  if @wiki.save
    flash[:notice] = "Your wiki  was saved."
    redirect_to todolists_url 
  else
    flash[:error] = "There was an error saving your wiki. Please try again."
    render :new
  end
  end

def destroy
    
    @wiki = Wiki.find(params[:id])
    @wiki.destroy
    
    flash[:notice] = "Successfully destroyed wiki."
    
    respond_to do |format|
      format.js 
    end
end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end

  def edit
  end
end
