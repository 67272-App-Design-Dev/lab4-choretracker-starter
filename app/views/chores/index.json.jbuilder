json.array!(@chores) do |chore|
  json.extract! chore, :id, :child_id, :task_id, :due_on, :completed
  json.url chore_url(chore, format: :json)
end
