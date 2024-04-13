class OpenaiApiClient
  include HTTParty
  base_uri 'https://api.openai.com/v1'
  headers 'Content-Type' => 'application/json'
  headers 'Authorization' => "Bearer #{ENV['OPENAI_API_KEY']}"

  def self.create_chat(prompt)
    body = {
      model: 'gpt-3.5-turbo',
      messages: [{role: 'user', content: prompt}]
    }
    response = post('/chat/completions', body: body.to_json)
    JSON.parse(response.body)
  end
end
