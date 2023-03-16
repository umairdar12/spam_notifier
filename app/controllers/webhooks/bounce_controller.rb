class Webhooks::BounceController < ApplicationController
    before_action :catch_response
    around_action :global_request_logging

    def handle
        @errors = []
        email, bounce_time = extract_params
        
        begin
            if @is_spam
                NotifySpam.new.notify_spam(email, bounce_time).deliver_message
                render plain: 'notified the spam'
            else
                render plain: "not a Spam"
            end
        rescue => e
            @errors << e.message
        end
    end

    private

    def catch_response
        @recieved_payload = params["bounce"]
        raise "The recieved payload is not valid!" if !verify_response
        @is_spam = @recieved_payload["Type"] == "SpamNotification"
    end

    def verify_response
        @recieved_payload && @recieved_payload["Type"] 
    end

    def extract_params
        email = @recieved_payload["Email"]
        bounce_time = @recieved_payload["BouncedAt"]&.to_datetime&.strftime('%b-%d-%Y %I:%M%p')
        return email, bounce_time
    end

    # to keeps track of requests
    def global_request_logging
        http_request_header_keys = request.headers.env.keys.select { |header_name| header_name.match("^HTTP.*|^X-User.*") }
        http_request_headers = request.headers.env.select { |header_name, header_value| http_request_header_keys.index(header_name) }
        puts "*" * 40
        pp request.method
        pp request.url
        pp request.remote_ip
        pp ActionController::HttpAuthentication::Token.token_and_options(request)
        
        http_request_header_keys.each do |key|
          puts ["%20s" % key.to_s, ":", request.headers[key].inspect].join(" ")
        end
        puts "-" * 40
        puts "%20s" % raw_post
        puts "*" * 40
        begin
          yield
        ensure
          puts response.body
        end
    end

    def raw_post
        @raw_post ||= request.raw_post
    end
end
