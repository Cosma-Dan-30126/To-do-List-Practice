<template>
  <v-dialog
      :value="true"
      persistent
      max-width="290"
    >
     
      <v-card>
        <v-card-title class="text-h5">
           Stergeti acest task?
        </v-card-title>
        <v-card-text>Sunteti sigur/a ca doriti sa stergeti acest task?</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn
           @click="$emit('close')" 
           text   
          >
            Nu
          </v-btn>
          <v-btn
           @click="$store.dispatch('deleteTask',task.id)" 
           color="red"
            text
            
          >
            Da
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
</template>

<script>
export default {
    props:['task']
}
</script>

<style>

</style>