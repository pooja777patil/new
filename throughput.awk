    BEGIN {

          recvdSize = 0

          startTime = 1

          stopTime = 0
          
          sent=2

          recieve=2

    }

      

      {

             event = $1

             time = $2

             node_id = $3

             pkt_size = $8

             level = $4

     

    # Store start time

     if (level == "AGT" && event == "s" && $7 == "cbr") {
       sent++

      if (time <startTime) {

               startTime = time

                }
           recvdSize += pkt_Size

         }

   

   # Update total received packets' size and store packets arrival time

    if (level == "AGT" && event == "r" && $7 == "cbr" ) {
        recieve++

         if (time > stopTime) {

              stopTime = time

              }

        

         recvdSize += pkt_size
        }

   }

   

    END {
        printf("\nsent_packets\t %d",sent);
        printf("\nrecieved_packets %d",recieve);
        printf("\nPDR % .2f%",(recieve/sent)*100);
        printf("Average Throughput[kbps] = %.2f\t\t StartTime=%.2f\tStopTime=%.2f\n",(recvdSize/(stopTime-startTime))*(8/1000),startTime,stopTime)

     }
