<template>
  <v-list
      pt-0
      subheader
      flat
  >

    <v-subheader>Task-urile se vor bifa doar dupa ce sunt indeplinite</v-subheader>
    <task 
    v-for="task in $store.state.tasks" 
    :key="task.id"
    :task="task" />
    
     </v-list> 
</template>

<script>
export default {
components:{
  'task':require('@/components/ToDo/Task.vue').default  
}
}
</script>

<style>

</style>