# Astreu

**High-performance Messaging System based on gRPC protocol**

![Astreu CI](https://github.com/eigr/Astreu/workflows/Astreu%20CI/badge.svg)

## Architecture Overview

```

                                     +-------------------------------+
                                     |           Astreu              |
                                     |                               |
                                     | +---------------------------+ |
    +-------------+                  | |     Management API        | |                   +-------------+
    | Subscribers |                  | +---------------------------+ |                   |  Producers  |
  +-------------+ |  Bi-directional  | +---------------------------+ |  Bi-directional   | +-------------+
+---------------| +----------------->+ |     PubSub Adapters       | +------------------>+ | +-------------+
| | |          || |    Streams       | +---------------------------+ |    Streams        | | |         | | |
| | |          || +<-----------------+ +---------------------------+ +<------------------+ | |         | | |
| | +-------------+                  | |      Core Protocol        | |                   +-------------+ | |
+-+-------------+                    | +---------------------------+ |                     +-------------+ |
                                     | +---------------------------+ |                       +-------------+
                                     | |        gRpc Server        | |
                                     | +---------------------------+ |
                                     +-------------------------------+


```

## Usage and Installation

```
# docker run --rm --net=host -e RELEASE_NODE=unique_name_peer_node eigr/astreu:0.1.0
```

