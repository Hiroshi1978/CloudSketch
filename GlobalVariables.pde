volatile boolean nowChanging = false;
float changingMessageLocation = -200;

Object lock = new Object();

volatile boolean showingInstanceDetail = false;
InstanceImage forcusedInstance;

volatile boolean showingLbDetail = false;
LoadBalancerImage forcusedLb;

