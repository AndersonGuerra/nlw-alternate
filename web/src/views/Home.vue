<template>
  <div id="page-home">
    <div class="content">
      <header>
        <img :src="logo" alt />
      </header>
      <main>
        <h1>Seu marketplace de coleta de resíduos.</h1>
        <p>Ajudamos pessoas a encontrarem pontos de coleta de forma eficiente.</p>
        <router-link to="/cadastro">
          <span>
            <LogInIcon />
          </span>
          <strong>Cadastre um ponto de coleta</strong>
        </router-link>
      </main>
    </div>
  </div>
</template>

<script>
import { LogInIcon } from "vue-feather-icons";
import logo from "@/assets/logo.svg";
export default {
  name: "Home",
  components: {
    LogInIcon
  },
  data() {
    return {
      logo: logo
    };
  }
};
</script>
<style scoped>
@import url("../assets/css/Home.css");
</style>
