json.extract! chore, :id, :child_id, :task_id, :due_on, :completed, :created_at, :updated_at
json.url chore_url(chore, format: :json)
