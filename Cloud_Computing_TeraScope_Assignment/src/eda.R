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
  ggtitle("Event Name vs Event Time in ms") +
  labs(x = "Event Name", y = "Event Time in ms") + 
  theme_minimal()