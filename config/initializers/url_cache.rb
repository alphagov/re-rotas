class UrlCache
  def initialize
    @cache = {}
    @jobs  = Set.new
    @mutex = Mutex.new
  end

  def update(url, body)
    @mutex.synchronize { @cache[url] = body }
  end

  def watch(url)
    unless @jobs.include?(url)
      UrlFetcherJob.perform_later(url)
      @jobs.add(url)
    end
  end

  def fetch(url)
    watch(url)

    loop do
      result = @mutex.synchronize { @cache.fetch(url, nil) }
      return result unless result.nil?

      sleep 1
    end
  end
end

module Rotas
  URL_CACHE = UrlCache.new
end

unless $0.match?(/rake/)
  PagerDutyCalendar.all.each do |calendar|
    Rails.logger.info "Starting url fetcher job for #{calendar.url}"
    Rotas::URL_CACHE.watch(calendar.url)
  end
end
