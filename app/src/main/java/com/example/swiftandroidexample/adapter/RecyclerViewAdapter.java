package com.example.swiftandroidexample.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.swiftandroidexample.R;
import com.example.swiftandroidexample.model.Task;

import java.util.List;

public class RecyclerViewAdapter extends RecyclerView.Adapter<RecyclerViewAdapter.MyViewHolder> {
    private Context context;
    private List<Task> taskModels;
    private final OnTaskItemClickListner taskItemClickListner;

    public RecyclerViewAdapter(Context context, List<Task> taskModels, OnTaskItemClickListner taskItemClickListner) {
        this.context = context;
        this.taskModels = taskModels;
        this.taskItemClickListner = taskItemClickListner;
    }

    public interface OnTaskItemClickListner {
        void onTaskDeleteClick(Task task);

        boolean onTaskItemLongClick(Task task);

        void onTaskEditClick(Task task);
    }

    @NonNull
    @Override
    public MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(context).inflate(R.layout.task_item_layout, parent, false);
        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull MyViewHolder holder, int position) {
        holder.bind(taskModels.get(position), taskItemClickListner);
    }

    @Override
    public int getItemCount() {
        return taskModels.size();
    }

    class MyViewHolder extends RecyclerView.ViewHolder {
        TextView titleTV;
        ImageView ivEdit, ivDelete;

        public MyViewHolder(@NonNull View itemView) {
            super(itemView);
            titleTV = (TextView) itemView.findViewById(R.id.titleTV);
            ivEdit = (ImageView) itemView.findViewById(R.id.iv_edit_task);
            ivDelete = (ImageView) itemView.findViewById(R.id.iv_delete_task);
        }

        public void bind(final Task task, final OnTaskItemClickListner taskItemClickListner) {
            titleTV.setText(task.getTitle());
            ivEdit.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    taskItemClickListner.onTaskEditClick(task);
                }
            });

            ivDelete.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    taskItemClickListner.onTaskDeleteClick(task);
                }
            });

            itemView.setOnLongClickListener(new View.OnLongClickListener() {
                @Override
                public boolean onLongClick(View view) {
                    return taskItemClickListner.onTaskItemLongClick(task);
                }
            });
        }
    }
}