## 🦘 Base Entity

### create,update time을 기록함
 모든 Entity 클래스에 extends BaseEntity 로 사용
```java
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
@Getter
public abstract class BaseEntity {
    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime creatTime;


    @UpdateTimestamp
    @Column(insertable = false)
    private LocalDateTime updateTime;
}
```
## 🧷 Table Join  

```java
@Entity
@Getter
@Setter
@Table(name = "board_table")
public class BoardEntity extends BaseEntity{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "board_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private MemberEntity memberEntity;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private CategoryEntity categoryEntity;

    @Column
    private String boardWriter;

    @Column
    private String boardTitle;

    @Column(length=2000)
    private String boardContents;

    @Column(columnDefinition = "integer default 0")
    private int boardHits;

    @Column(columnDefinition = "integer default 0")
    private int likeCount;

    @Column
    private String boardFileName;

    @OneToMany(mappedBy = "boardEntity", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CommentEntity> commentEntityList = new ArrayList<>();
    @OneToMany(mappedBy = "boardEntity", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    private List<LikeEntity> likeEntityList = new ArrayList<>();

    public static BoardEntity toBoardEntitySave(BoardSaveDTO boardSaveDTO, MemberEntity memberEntity, CategoryEntity categoryEntity){
        BoardEntity boardEntity = new BoardEntity();
        boardEntity.setMemberEntity(memberEntity);
        boardEntity.setCategoryEntity(categoryEntity);

        boardEntity.setBoardWriter(memberEntity.getMemberNickName());
        boardEntity.setBoardTitle(boardSaveDTO.getBoardTitle());
        boardEntity.setBoardContents(boardSaveDTO.getBoardContents());
        boardEntity.setBoardFileName(boardSaveDTO.getBoardFileName());

        return boardEntity;
    }

    public static BoardEntity toBoardUpdateEntity(BoardUpdateDTO boardUpdateDTO, MemberEntity memberEntity,CategoryEntity categoryEntity){
        BoardEntity boardEntity = new BoardEntity();
        boardEntity.setId(boardUpdateDTO.getBoardId());
        boardEntity.setMemberEntity(memberEntity);
        boardEntity.setCategoryEntity(categoryEntity);

        boardEntity.setBoardWriter(memberEntity.getMemberNickName());
        boardEntity.setBoardTitle(boardUpdateDTO.getBoardTitle());
        boardEntity.setBoardContents(boardUpdateDTO.getBoardContents());
        boardEntity.setBoardFileName(boardUpdateDTO.getBoardFileName());
        boardEntity.setLikeCount(boardUpdateDTO.getLikeCount());
        boardEntity.setBoardHits(boardUpdateDTO.getBoardHits());

        return boardEntity;
    }



}

```
