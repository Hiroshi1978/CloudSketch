Map<String,ZoneImage> zImages;
Map<String,InstanceImage> iImages;
Map<String,LoadBalancerImage> lImages;
List<HealthCheckImage> hcImages;

Map<ZoneImage,Set<InstanceImage>> instancesOfZone;
Map<LoadBalancerImage,Set<ZoneImage>> zonesOfLb;
Map<LoadBalancerImage,Set<InstanceImage>> instancesOfLb;
