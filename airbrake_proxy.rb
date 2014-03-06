require 'sinatra'
require 'json'
require 'rest-client'

TOKEN = ENV["SLACK_TOKEN"]
raise "No SLACK_TOKEN environment variable defined. You need this in order to post to Slack" unless TOKEN

helpers do
  def receive_error
    message = request.body.string
    data = JSON.parse message
    payload = {text: JSON.pretty_unparse(data)}
    url = 'https://bendyworks.slack.com/services/hooks/incoming-webhook?token=' + TOKEN
    RestClient.post url, payload.to_json 
    puts payload
  end
end

post '/' do
  receive_error
end
