module Projects
  class Create
    def initialize

    end

    def create(params:)
      params = whitelist_params(params)
      if 'id'.in?(params.keys)
        Project.find(params[:id]).update(params)
      else
        Project.create(params)
      end

    rescue StandardError => e
      e
    end

    private

    def whitelist_params(params)
      params.require(:project)
          .permit(:id,
                  :name,
                  :description,
                  :workingdays)
    end

  end
end