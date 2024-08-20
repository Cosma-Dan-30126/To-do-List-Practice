<template>
  <v-app id="inspire">
   <v-app-bar app
      
      color="primary"
      dark
      shrink-on-scroll
      src="sea.jpg"
      prominent
    >
      <v-app-bar-title>Lista Task-uri</v-app-bar-title>

      <v-spacer></v-spacer>
    </v-app-bar>

    <v-main>
     <router-view></router-view> 
    </v-main>
  </v-app>
</template>

<script>
  export default {
   
  }
</script>
