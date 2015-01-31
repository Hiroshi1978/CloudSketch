ExecutorService pool;
ExecutorService pool2 = Executors.newFixedThreadPool(5);

void setupThreadPool(){
  pool = Executors.newFixedThreadPool(5);
}

