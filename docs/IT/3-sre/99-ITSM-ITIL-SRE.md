---
sidebar_position: 99
---

# ITSM, ITIL, SRE

## ITSM

In the world of tech, basic fundamentals include `Information Technology Service Management` (ITSM), a systematic approach through which IT teams oversee the complete lifecycle of IT services provided to customers. This includes all processes and actions involved in designing, creating, delivering and supporting IT services. Crucial for maintaining consistent product performance, ITSM consists of:   
- service management - quản lý service
- change management - quản lý thay đổi
- problem and incident management - xử lý sự cố và root cause.
- asset management and knowledge management.

Central to ITSM are five key stages that guide its implementation:
- Service strategy
- Service design
- Service transition
- Service operation
- Continual service improvement

The evolution of tech has given rise to various ITSM frameworks. Among the most prominent are the Information Technology Infrastructure Library (ITIL) and site reliability engineering (SRE). Each offers unique benefits and applications tailored to different organizational needs and contexts.


## ITIL (IT Infrastructure Library)
Khái niệm: Bộ khung thực hành tốt nhất (best practices framework) cho ITSM. ITIL là cách triển khai ITSM.

ITSM là khái niệm, ITIL là framework để thực hiện ITSM.   

ITIL 4 (phiên bản hiện tại) gồm:   
- Service Value System (SVS)   
- 4 Dimensions Model   
- 34 Management Practices (thay thế 26 processes của ITIL v3)   

Vòng đời dịch vụ (ITIL v3):  
```
Strategy → Design → Transition → Operation → Continual Improvement
```

## SRE
Khái niệm: Phương pháp do Google phát triển, áp dụng kỹ thuật phần mềm vào vận hành hệ thống để đảm bảo độ tin cậy.


## ITIL và SRE
SRE không được thiết kế để thực hành ITSM, mà là một cách tiếp cận độc lập từ góc độ kỹ thuật phần mềm. Tuy nhiên trong thực tế, SRE giải quyết nhiều vấn đề giống ITSM nên người ta thường đặt chúng cạnh nhau.

```
ITSM (umbrella)
├── ITIL (framework/process)
└── SRE (engineering practice)
```

SRE và ITIL đều có thể được xem là cách tiếp cận để đạt mục tiêu của ITSM, nhưng:
- ITIL được thiết kế rõ ràng cho ITSM
- SRE được Google tạo ra để giải quyết bài toán reliability ở scale lớn, không phải để làm ITSM — nhưng kết quả cuối cùng overlap nhau




`References:`
https://www.materialplus.io/sg/perspectives/information-technology-infrastructure-library-itil-vs-site-reliability-engineering-sre-which-is-right-for-your-organization    
https://www.atlassian.com/itsm/itil    
https://www.blameless.com/blog/itil-devops-sre-work-together   