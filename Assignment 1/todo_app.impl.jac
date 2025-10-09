// Implementation for the 'add_task' ability
impl TaskManager.add_task {
    // 1. Call the AI ability to get a suggested priority
    priority_level = suggest_priority(self.title);

    // 2. Validate and clamp the AI output to be a valid priority (1, 2, or 3)
    if priority_level < 1 {
        priority_level = 1;
    } elif priority_level > 3 {
        priority_level = 3;
    }

    // 3. Create a new 'task' node and link it to the root
    root ++> task(title=self.title, priority=priority_level);

    print(f"✅ Task '{self.title}' added with AI Priority: {priority_level}");
}

// Implementation for the 'list_tasks' ability
impl TaskManager.list_tasks {
    tasks_to_report = [];
    
    // 1. Visit all 'task' nodes linked from the 'root'
    visit [root --> task];
    
    // 2. Collect and store the task data
    for here in self.get_context().get_visited_nodes() {
        if here is task { 
            tasks_to_report.append({
                "title": here.title,
                "priority": here.priority,
                "status": here.status
            });
        }
    }
    
    // 3. Sort the tasks by priority (highest first) for display
    sorted_tasks = sorted(tasks_to_report, key=lambda x: x["priority"], reverse=True);

    print("\n--- PENDING TASKS (Sorted by AI Priority) ---");
    for t in sorted_tasks {
        print(f"[P{t.priority}] {t.title} ({t.status})");
    }
    print("------------------------------------------");

    disengage; // Stop the walker
}