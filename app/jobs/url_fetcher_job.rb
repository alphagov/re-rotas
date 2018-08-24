class UrlFetcherJob < ActiveJob::Base
  queue_as :default

  attr_accessor :url

  def perform(url)
    @url = url

    logger.info "UrlFetcherJob Performing GET #{@url} "
    response = HTTP.get(@url)
    logger.info "UrlFetcherJob Response #{response.code} #{@url}"

    logger.info "UrlFetcherJob Caching #{@url} "
    WhoIsOnCall::URL_CACHE.update(@url, response.body.to_s)
    logger.info "UrlFetcherJob Cached #{@url} "
  rescue HTTP::Error => e
    logger.error e
  end

  after_perform do |job|
    logger.info "UrlFetcherJob Enqueued #{@url} "
    job
      .class
      .set(wait: 5.minutes)
      .perform_later(job.url)
  end
end
