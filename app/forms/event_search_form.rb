class EventSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string # 1
  attribute :page, :integer #2

  def search #3
    Event.search(
      keyword_for_search,
      where: { start_at: { gt: start_at } },
      page: page,
      per_page: 10
    )
  end

  def start_at #4
    @start_at || Time.current
  end

  def start_at=(new_start_at) #5
    @start_at = new_start_at.in_time_zone
  end

  private

  def keyword_for_search #6
    keyword.presence || "*"
  end
end