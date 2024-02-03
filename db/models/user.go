package models

type User struct {
	ID                    uint64 `gorm:"column:id"`
	Username              string `gorm:"column:username"`
	Password              string `gorm:"column:password"`
	Image                 string `gorm:"column:image"`
	Bio                   string `gorm:"column:bio"`
	DisplayProfilePicture bool   `gorm:"column:display_profile_picture;default:true"`
}
