module Merged
  class PagesController < MergedController
    before_action :set_page, only: %i[ show edit update destroy ]

    # GET /merged/pages
    def index
      @pages = Page.all.values
    end

    # GET /merged/pages/1
    def show
    end

    # GET /merged/pages/new
    def new
    end

    # GET /merged/pages/1/edit
    def edit
    end

    # POST /merged/pages
    def create
      @page = Merged::Page.new(page_params)

      if @page.save
        redirect_to @page, notice: "Page was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /merged/pages/1
    def update
      if @page.update(page_params)
        redirect_to @page, notice: "Page was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /merged/pages/1
    def destroy
      @page.destroy
      redirect_to page_url, notice: "Page was successfully destroyed."
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_page
        @page = Page.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def page_params
        params.fetch(:page, {})
      end
  end
end
