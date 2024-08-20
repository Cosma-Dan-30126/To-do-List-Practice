<template>
  <div class="home">

    <list-tasks v-if="$store.state.tasks.length" />
     <div v-else>
<div class="text-h6">Nu exista task-uri!</div>
     </div>
    <field-add-task />
      
 
  </div>
</template>

<script>
  import FieldAddTask from '@/components/ToDo/FieldAddTask.vue'
  import ListTasks from '@/components/ToDo/ListTasks.vue'
  export default {
    name: 'Home',
    
    components:{
     'field-add-task': FieldAddTask,
     'list-tasks': ListTasks,

    }
    }
  
</script>

