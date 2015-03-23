class CollaboratorsController < ApplicationController

  def create
    user = User.find(params[:user])
    @wiki = Wiki.find(params[:wiki_id])
    collaborator = @wiki.collaborators.build(user: user, wiki: @wiki)

    if collaborator.save
      flash[:notice] = "Collaborator added"
      redirect_to wiki_path(@wiki.id)
    else
      flash[:error] = "Oops, collaborator not added"
      redirect_to edit_wiki_path(@wiki.id)
    end

  end

  def destroy
    collaborator = Collaborator.find(params[:id])
    wiki = Wiki.find(params[:wiki_id])

    if collaborator.destroy
      flash[:notice] = "Collaborator removed"
      redirect_to wiki_path(wiki.id)
    else
      flash[:error] = "Collaborator wasn't removed, please try again"
      redirect_to edit_wiki_path(wiki.id)
    end
  end

end
