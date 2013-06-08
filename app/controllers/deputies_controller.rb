class DeputiesController < InheritedResources::Base
  has_scope :page, :default => 1

  def index
    index! do |format|
      format.html do
        if request.xhr?
          render @deputies
        else
          render :index
        end
      end
    end
  end

  protected
  def collection
    @deputies ||= end_of_association_chain.includes(suspicious_companies: :company)
  end
end
