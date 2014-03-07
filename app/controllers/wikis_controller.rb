class WikisController < ApplicationController
  
  respond_to :html, :js
  
  def index
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def create
  @wiki = Wiki.new(wiki_params)
    
    if @wiki.save
    render :action => 'new'
    else
    flash[:notice] = "Wiki succesfully created"
    end
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    
    if @wiki.update_attributes(wiki_params)
      redirect_to wikis_url, notice: "Wiki was saved successfully."
    else
      flash[:error] = "Error saving wiki. Please try again"
      render :edit
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
    params.require(:wiki).permit(:title, :body, :private )
  end
  
end

