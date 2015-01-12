class DocumentsController < ApplicationController
  def show
    fresh_when etag: @recording
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    respond_to do |format|
      if @document.save
        format.html { redirect_to edit_document_path(@document), notice: "Created successfully" }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(document_params)
        format.html { redirect_to edit_user_contact_path(current_user, @document), notice: "Contact successfully updated." }
      else
        format.html { render action: "edit" }
      end
    end
  end

  private
    def document_params
      params.require(:document).permit(:title, :content)
    end
end

