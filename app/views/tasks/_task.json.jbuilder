json.extract! task, :id, :name, :points, :active, :created_at, :updated_at
json.url task_url(task, format: :json)
