"""
cdkharris 2023-09-29
A script to make a simple chart that tracks cloud-init's progress
cloud_init_times = list of timestamps
t0 = start time
elapsed = seconds elapsed since t0
"""

from datetime import datetime
import matplotlib.pyplot as plt
import numpy as np

# get the timestamps from cloud-init.log
cloud_init_times = []
with open('./cloud-init.log', 'r') as f:
    for line in f:
        if line[0] == '2':
            ts = datetime.fromisoformat(line[:19]).timestamp()
            cloud_init_times.append(ts)

# calculate the elapsed time
t0 = cloud_init_times[0]
elapsed = np.array(cloud_init_times) - t0

# plot the elapsed time vs the index of the timestamp
ax = plt.subplot()
ax.plot(elapsed)
ax.set_ylabel('t [s]')
ax.set_xlabel('index of cloud-init timestamps')
plt.savefig('cloud-init-log.png')
