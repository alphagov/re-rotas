require 'thread'

class UrlCache
  def initialize
    @cache = {}
    @mutex = Mutex.new
  end

  def update(url, body)
    @mutex.synchronize { @cache[url] = body }
  end

  def fetch(url)
    loop do
      result = @mutex.synchronize { @cache.fetch(url, nil) }
      return result unless result.nil?
      sleep 1
    end
  end
end

module WhoIsOnCall
  URL_CACHE = UrlCache.new
end

PagerDutyCalendar.all.each do |calendar|
  Rails.logger.info "Starting url fetcher job for #{calendar.url}"
  UrlFetcherJob.perform_later calendar.url
end
