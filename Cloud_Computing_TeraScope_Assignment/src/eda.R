##### Question 1
gpu_checkpoints %>%
  group_by(eventName)%>%
  summarise(med = mean(powerDrawWatt)) %>%
  ggplot(aes(x = reorder(eventName, +med), y = med, fill = med)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=round(med, digits = 0)), vjust=1.2, color="red", size=3.5)+
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  guides(fill=guide_legend(title="Average Power Consumed in Watts")) +
  ggtitle("Event Name vs Average Power Consumed in Watts") +
  labs(x = "Event Name", y = "Average Power Consumed in Watts") + 
  theme_minimal()

#Graphical Summary of Event Name vs Average GPU Temp in C
gpu_checkpoints %>%
  group_by(eventName)%>%
  summarise(med = mean(gpuTempC)) %>%
  ggplot(aes(x = reorder(eventName, +med), y = med, fill = med)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=round(med, digits = 0)), vjust=1.2, color="red", size=3.5)+
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  guides(fill=guide_legend(title="Average GPU Temp in C")) +
  ggtitle("Event Name vs Average GPU Temp in C") +
  labs(x = "Event Name", y = "Average GPU Temp in C") + 
  theme_minimal()

#Graphical Summary of Event Name vs Event Time in ms
gpu_checkpoints %>%
  group_by(eventName)%>%
  summarise(med = mean(eventTime_in_ms)) %>%
  ggplot(aes(x = reorder(eventName, +med), y = med, fill = med)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=round(med, digits = 0)), vjust=1.2, color="red", size=3.5)+
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  guides(fill=guide_legend(title="Event Time")) +
  ggtitle("Event Name vs Event Time in ms") +
  labs(x = "Event Name", y = "Event Time in ms") + 
  theme_minimal()



##### Question 2
#Graphical Summary of Zoom Level vs Power Draw in Watts
gpu_checkpoints_task %>%
  group_by(level)%>%
  summarise(med = mean(powerDrawWatt)) %>%
  ggplot(aes(x = reorder(level, +med), y = med, fill = med)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=round(med, digits = 0)), vjust=1.2, color="red", size=3.5)+
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  guides(fill=guide_legend(title="Power Draw")) +
  ggtitle("Zoom Level vs Power Draw in Watts") +
  labs(x = "Zoom Level", y = "Power Draw in Watts") + 
  theme_minimal()


#Graphical Summary of Zoom Level vs GPU Temperature in C
gpu_checkpoints_task %>%
  group_by(level)%>%
  summarise(med = mean(gpuTempC)) %>%
  ggplot(aes(x = reorder(level, +med), y = med, fill = med)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=round(med, digits = 0)), vjust=1.2, color="red", size=3.5)+
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  guides(fill=guide_legend(title="GPU Temp")) +
  ggtitle("Zoom Level vs GPU Temperature in C") +
  labs(x = "Zoom Level", y = "GPU Temperature in C") + 
  theme_minimal()


#Graphical Summary of Zoom Level vs Event Time in ms
gpu_checkpoints_task %>%
  group_by(level)%>%
  summarise(med = mean(eventTime_in_ms)) %>%
  ggplot(aes(x = reorder(level, +med), y = med, fill = med)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=round(med, digits = 0)), vjust=1.2, color="red", size=3.5)+
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  guides(fill=guide_legend(title="Event Time")) +
  ggtitle("Zoom Level vs Event Time in ms") +
  labs(x = "Zoom Level", y = "Event Time in ms") + 
  theme_minimal()