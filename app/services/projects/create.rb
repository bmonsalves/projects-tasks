module Projects
  class Create
    include ::Concerns::Messages

    def initialize; end

    def create(params:)
      params = whitelist_params(params)
      project = if 'id'.in?(params.keys)
                  Project.find(params[:id]).update(params)
                else
                  Project.create(params)
                end

      ImmutableStruct.new(:project)
                     .new(project: project)

    rescue StandardError => e
      error(message: e, code: 500)
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