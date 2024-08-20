<template>
  <div>
      

      
        <v-list-item
         @click="$store.commit('TaskExecutat',task.id)"
         :class="{'orange lighten-4':task.done}"
         >
          <template v-slot:default>
            <v-list-item-action>
              <v-checkbox
                :input-value="task.done"
                color="orange darken-4"
              ></v-checkbox>
            </v-list-item-action>

            <v-list-item-content>
              <v-list-item-title :class="{'text-decoration-underline' : task.done}">
                {{task.titlu}}
                </v-list-item-title>
             
            </v-list-item-content>
           
        <v-list-item-action>
          <v-btn @click.stop="dialogs.edit=true " icon >
            <v-icon color="grey lighten-1">mdi-pencil-circle </v-icon>
          </v-btn>
        </v-list-item-action>
       
          

        <v-list-item-action>
          <v-btn @click.stop="dialogs.delete=true" icon>
            <v-icon color="grey lighten-1">mdi-trash-can</v-icon>
          </v-btn>
        </v-list-item-action>
        
          </template>
          
        </v-list-item>
        <v-divider></v-divider>
        
      <dialog-edit  
      v-if="dialogs.edit" 
      @close="dialogs.edit=false"
      :task="task"

      />   
      <dialog-delete 
      v-if="dialogs.delete" 
      @close="dialogs.delete=false"
      :task="task"

      />  
     
    </div> 
</template>

<script>
export default {
    props:['task'],
    data()
    {
        return{
           dialogs:{
            edit: false,
            delete: false
           } 
        }
    },
    components:{
        'dialog-edit':require('@/components/ToDo/Dialogs/DialogEdit.vue').default,
        'dialog-delete':require('@/components/ToDo/Dialogs/DialogDelete.vue').default
        

    }

}
</script>

<style>

</style>