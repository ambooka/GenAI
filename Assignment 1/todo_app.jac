# 
# AI-Powered To-Do List Application using Jaclang and byLLM
# 
# This file demonstrates the core logic for a To-Do application.
# The 'by llm()' keyword is used to delegate complex, pattern-based
# logic (like categorization and list generation) directly to an LLM.
#
# To run this code, you would need the Jaclang environment set up:
# pip install jaclang jac-byllm
# jac run todo_ai_backend.jac
#

# 1. Imports and Model Initialization
# We import the Model class from byllm to access the LLM.
import from byllm { Model }

# Define the global LLM model instance.
# byllm handles prompt construction and parsing automatically.
glob llm = Model(model_name="gemini/gemini-2.5-flash");


# 2. Data Structures for the To-Do Application

# Enum for task categories, used for structured AI output
enum Category {
    WORK,
    PERSONAL,
    FINANCE,
    HEALTH,
    LEARNING,
    UNCATEGORIZED
}

# Object to represent a single Subtask, used for structured output
obj Subtask {
    has description: str;
    has estimated_duration_minutes: int;
}

# Object to represent the main Task
obj Task {
    has title: str;
    has category: Category = Category.UNCATEGORIZED;
    has completed: bool = false;
    has subtasks: list[Subtask] = [];
}


# 3. AI-Powered Functions using 'by llm()'

# AI Function 1: Categorize a task based on its title.
# byllm automatically constrains the output to the defined 'Category' enum.
# The function signature acts as the prompt for the LLM.
def categorize_task(task_title: str) -> Category 
    by llm();

# AI Function 2: Generate a structured list of subtasks for a complex task.
# byllm automatically parses the LLM's raw output into a list of Subtask objects.
def suggest_subtasks(task_title: str) -> list[Subtask] 
    by llm();


# 4. Walker for Application Logic
# Walkers are the execution agents in Jac, traveling through the object graph.
# Here, we use a walker to simulate the process of adding and enhancing a task.
walker process_task {
    # The 'init' block runs when the walker is created
    has input_title: str;

    # The 'entry' block is where the main execution starts
    with entry {
        print("\n--- Processing New Task ---");
        print(f"Input: {self.input_title}");

        # Create a new Task object
        task = Task(title=self.input_title);

        # Use AI to categorize the task
        task.category = categorize_task(self.input_title);
        print(f"-> AI Category: {task.category}");

        # Use AI to generate subtasks
        task.subtasks = suggest_subtasks(self.input_title);
        
        # Display the full structured task object
        print("\n--- Final Structured Task ---");
        print(f"Title: {task.title}");
        print(f"Category: {task.category}");
        print(f"Status: {'Done' if task.completed else 'Pending'}");
        
        if (len(task.subtasks) > 0) {
            print("\nSuggested Subtasks:");
            for subtask in task.subtasks {
                print(f"  - {subtask.description} ({subtask.estimated_duration_minutes} min)");
            }
        }
    }
}


# 5. Application Entry Point (Simulation)
with entry {
    # 1. Example 1: Simple task categorization
    process_task(input_title="Email quarterly budget report to finance team");

    # 2. Example 2: Complex task requiring subtask breakdown
    process_task(input_title="Plan and execute the website redesign project");

    # 3. Example 3: Personal health task
    process_task(input_title="Research and sign up for a local pottery class");
}
