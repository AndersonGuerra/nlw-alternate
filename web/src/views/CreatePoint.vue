<template>
  <div id="page-create-point">
    <header>
      <img :src="logo" alt />
      <router-link to="/">
        <ArrowLeftIcon />Voltar para a home
      </router-link>
    </header>
    <form v-on:submit.prevent="handleFormSubmit">
      <h1>
        Cadastro do
        <br />ponto de coleta
      </h1>
      <fieldset>
        <legend>
          <h2>Dados</h2>
        </legend>
        <div class="field">
          <label for="name">Nome da entidade</label>
          <input v-model="formData.name" type="text" name="name" id="name" />
        </div>
        <div class="field-group">
          <div class="field">
            <label for="email">E-mail</label>
            <input v-model="formData.email" type="email" name="email" id="email" />
          </div>
          <div class="field">
            <label for="whatsapp">WhatsApp</label>
            <input v-model="formData.whatsapp" type="text" name="whatsapp" id="whatsapp" />
          </div>
        </div>
      </fieldset>
      <fieldset>
        <legend>
          <h2>Endereço</h2>
          <span>Selecione o endereço no mapa</span>
        </legend>
        <LMap :center="mapCenter" :zoom="15" @click="handleMapClick">
          <LTileLayer :url="layerUrl"></LTileLayer>
          <LMarker :lat-lng="markerLatLng"></LMarker>
        </LMap>
        <div class="field-group">
          <div class="field">
            <label for="uf">Estado (UF)</label>
            <select v-model="formData.uf" name="uf" id="uf">
              <option value="0">Selecione uma UF</option>
              <option :value="uf" v-for="uf in ufs" :key="uf">{{uf}}</option>
            </select>
          </div>
          <div class="field">
            <label for="city">Cidade</label>
            <select v-model="formData.city" name="city" id="city">
              <option value="0">Selecione uma cidade</option>
              <option :value="city" v-for="city in cities" :key="city">{{city}}</option>
            </select>
          </div>
        </div>
      </fieldset>
      <fieldset>
        <legend>
          <h2>Itens de coleta</h2>
          <span>Selecione um ou mais itens abaixo</span>
        </legend>
        <ul class="items-grid">
          <li
            v-for="item in items"
            v-bind:class="{selected: selectedItems.includes(item.id)}"
            :key="item.id"
            @click="handleSelectItem(item.id)"
          >
            <img :src="item.image_url" :alt="item.title" />
            <span>{{item.title}}</span>
          </li>
        </ul>
      </fieldset>
      <button>Cadastrar ponto de coleta</button>
    </form>
  </div>
</template>
<script>
import api from "../services/api";
import axios from "axios";
import logo from "@/assets/logo.svg";
import { ArrowLeftIcon } from "vue-feather-icons";

export default {
  name: "CreatePoint",
  components: {
    ArrowLeftIcon
  },
  watch: {
    "formData.uf": function(selectedUf) {
      if (selectedUf !== 0) {
        axios
          .get(
            `https://servicodados.ibge.gov.br/api/v1/localidades/estados/${selectedUf}/municipios`
          )
          .then(r => {
            this.cities = r.data.map(city => city.nome);
          });
      } else {
        // this.formData.city = 0;
      }
    }
  },
  data() {
    return {
      logo: logo,
      mapCenter: [0.03585, -51.06221],
      layerUrl: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      markerLatLng: [0.03585, -51.06221],
      items: [],
      selectedItems: [],
      ufs: [],
      cities: [],
      formData: {
        uf: 0,
        city: 0
      }
    };
  },
  created() {
    navigator.geolocation.getCurrentPosition(position => {
      const { latitude, longitude } = position.coords;
      this.markerLatLng = [latitude, longitude];
      this.mapCenter = [latitude, longitude];
    });
    api.get("items").then(r => {
      this.items = r.data;
    });
    axios
      .get("https://servicodados.ibge.gov.br/api/v1/localidades/estados")
      .then(r => {
        this.ufs = r.data.map(uf => uf.sigla);
      });
  },
  methods: {
    handleMapClick(e) {
      this.markerLatLng = [e.latlng.lat, e.latlng.lng];
    },
    async handleFormSubmit() {
      const { name, email, whatsapp, city, uf } = this.formData;
      const [latitude, longitude] = this.markerLatLng;
      const items = this.selectedItems;
      const data = {
        name,
        email,
        whatsapp,
        city,
        uf,
        latitude,
        longitude,
        items
      };
      await api.post("points", data);

      alert("Ponto de coleta criado!");

      this.$router.push("/");
    },
    handleSelectItem(id) {
      const alreadySelected = this.selectedItems.findIndex(item => item === id);
      if (alreadySelected >= 0) {
        this.selectedItems.splice(alreadySelected, 1);
      } else {
        this.selectedItems.push(id);
      }
    }
  }
};
</script>
<style scoped>
@import url("../assets/css/CreatePoint.css");
</style>