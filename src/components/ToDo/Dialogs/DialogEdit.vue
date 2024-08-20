<template>
  <v-dialog
      :value="true"
      persistent
      max-width="290"
    >
     
      <v-card>
        <v-card-title class="text-h5">
           Editati acest task?
        </v-card-title>
        <v-card-text>
          Noul task este:
        <v-text-field
         v-model="NouTitlu"
         @keyup.enter="saveTask"
         />

        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
           @click="$emit('close')" 
           text   
          >
            Anulati
          </v-btn>
          <v-btn
           @click="saveTask" 
           :disabled="TitluInvalid"
           color="red"
            text
            
          >
            Efectuati
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
</template>

<script>
export default {
    props:['task'],
    data(){
      return{
     NouTitlu: null
      }
    },

  computed:{
    TitluInvalid(){
      return !this.NouTitlu || this.NouTitlu===this.task.titlu
    }
  },

    methods:{
      saveTask(){
        if(!this.TitluInvalid){
          let obiect ={
          id:this.task.id,
          titlu:this.NouTitlu
        }
        this.$store.commit('UpdateTitlu',obiect)
        this.$emit('close')
        }
        
      }
    },
    mounted(){
      this.NouTitlu=this.task.titlu
    }

}
</script>

<style>

</style>