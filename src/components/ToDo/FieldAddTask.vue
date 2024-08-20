<template>
    <v-text-field
      @keyup.enter="AddTask" 
      v-model="newTaskAdd"
            solo
            pa-4
            label="Adaugati un nou task"
            hide-details
            clearable
          >
          
          <template v-slot:append>
            <v-icon
            @click="AddTask"
            color="green"
            :disabled="newTaskAddInvalid"
            >
          mdi-plus-circle</v-icon>
          </template>
          
          </v-text-field>
</template>

<script>

export default {
    data(){
      return{
        newTaskAdd:''
        
      }
    },

    computed:{
        newTaskAddInvalid(){
            return !this.newTaskAdd
        }
    },
    methods:{
      
      AddTask()
      { if(!this.newTaskAddInvalid){
         this.$store.commit('AddTask',this.newTaskAdd)
        this.newTaskAdd=''
      }
       
      },
      

    },
    
}
</script>

<style>

</style>
