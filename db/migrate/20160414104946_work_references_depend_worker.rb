class WorkReferencesDependWorker < ActiveRecord::Migration
  def change
    rename_column :work_references, :worker_user_id, :worker_id
  end
end
