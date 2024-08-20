import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    tasks:[
      {
      id: 1,
      titlu:'Trezirea la ora 8 A.M.',
      done: false
      },
      {
        id: 2,
        titlu:'Prepararea unei omlete.',
        done: false
        },
        {
          id: 3,
          titlu:'Pregatirea pentru lucru.',
          done: false
          },
         {
            id: 4,
            titlu:'Alimentarea masinii.',
            done: false
            },
    ]
  },
  getters: {
  },
  mutations: {
    AddTask(state,newTaskAdd){
      let newTask={
        id:Date.now(),
        titlu:newTaskAdd,
        done: false
      }
      state.tasks.push(newTask)
      
    },
    TaskExecutat(state,id){
      let task= state.tasks.filter(task=> task.id ===id)[0]
      task.done=!task.done
    },

    deleteTask(state,id){
      state.tasks=state.tasks.filter(task =>task.id!=id)
    },
    UpdateTitlu(state,obiect){
      let task= state.tasks.filter(task=> task.id ===obiect.id)[0]
      task.titlu=obiect.titlu
    },
  },
  actions: {
    deleteTask({commit},id){
      commit('deleteTask',id)
    },
  },
  
})
