import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import { LMap, LTileLayer, LMarker } from "vue2-leaflet";
import { Icon } from "leaflet";
import "leaflet/dist/leaflet.css";
import "./assets/css/App.css";

Vue.component("LMap", LMap);
Vue.component("LTileLayer", LTileLayer);
Vue.component("LMarker", LMarker);

delete Icon.Default.prototype._getIconUrl;
Icon.Default.mergeOptions({
  iconRetinaUrl: require("leaflet/dist/images/marker-icon-2x.png"),
  iconUrl: require("leaflet/dist/images/marker-icon.png"),
  shadowUrl: require("leaflet/dist/images/marker-shadow.png"),
});

Vue.config.productionTip = false;
new Vue({
  router,
  render: (h) => h(App),
}).$mount("#app");
