json.array!(@tasks) do |task|
  json.extract! task, :id, :type, :label, :text
  json.url task_url(task, format: :json)
end
