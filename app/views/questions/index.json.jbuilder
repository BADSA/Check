json.array!(@questions) do |question|
  json.extract! question, :id, :title, :type, :choice1, :choice2, :choice3, :choice4, :right_answer
  json.url question_url(question, format: :json)
end
